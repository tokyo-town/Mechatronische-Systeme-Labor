%==========================================================
% Function to generate a Bode plot by using an Agilent oscilloscope
% See "start.m" for the usage.
%=========================================================

function result = BodePlotLockin(inData)

%Bode plot setting
Vout_op = inData.Vout_op;       %[Vop]
list_size = inData.data_points;
wait_cycles = inData.wait_cycles;

Freq_List = logspace(inData.start_freq, inData.end_freq, list_size);
Amp_List = zeros(1, list_size);
Pha_List = zeros(1, list_size);

Oscillo = visa('agilent',inData.instrument);
Oscillo.InputBufferSize = 10^7;     % 10M bytes
Oscillo.ByteOrder = 'littleEndian';
Oscillo.Timeout = 5;                
fopen(Oscillo);

% Clear command and default setting
fprintf(Oscillo, '*CLS');  
%fprintf(Oscillo, ':SYSTem:PRESet');                                         % [Default Setup]
pause(2);
fprintf(Oscillo, ':CHANnel1:DISPlay 1');  
fprintf(Oscillo, ':CHANnel2:DISPlay 2');  
fprintf(Oscillo, ':CHANnel1:OFFSet 0');  
fprintf(Oscillo, ':CHANnel2:OFFSet 0');  

fprintf(Oscillo, ':MEASure:FREQuency CHANnel1');  
% Triger
fprintf(Oscillo, ':TRIGger:MODE EDGE');
fprintf(Oscillo, ':TRIGger:SOURce WGEN'); 
% Acquisition
fprintf(Oscillo,':WAVEFORM:BYTEORDER LSBFirst');
fprintf(Oscillo,  ':WAVeform:POINts:MODE RAW');
fprintf(Oscillo, ':WAVeform:FORMat BYTE');
fprintf(Oscillo, ':WGEN:OUTPut 1'); 

for j=1: list_size
    %Fucntion generator (NR3 format)===============
    fprintf(Oscillo, ':WGEN:FUNCtion SINusoid');                                % Sin wave
    fprintf(Oscillo, strjoin({':WGEN:FREQuency' num2str(Freq_List(j))}));          % Frequency
    fprintf(Oscillo, strjoin({':WGEN:VOLTage' num2str(Vout_op*2)}));           % Amplitude
    fprintf(Oscillo, strjoin({':WGEN:VOLTage:OFFSet' num2str(0)}));             % Offset [V]
    

    %Scaling and Data acquisition==============================
    pause(wait_cycles*6/Freq_List(j));
    fprintf(Oscillo, ':SINGle');
    
    %Wait for "Stop"
    fprintf(Oscillo, 'OPERegister:CONDition?');
    isBusy = fscanf(Oscillo, '%f');
    isBusy = dec2bin(isBusy, 12);
    while isBusy(9) == '1'
        pause(0.5);
        fprintf(Oscillo, 'OPERegister:CONDition?');
        isBusy = fscanf(Oscillo, '%f');
        isBusy = dec2bin(isBusy, 12);
    end
    
    fprintf(Oscillo, strjoin({':TIMebase:RANGe' num2str(6/Freq_List(j))}));     % 6 period in the display
    fprintf(Oscillo, strjoin({':CHANnel1:RANGe' num2str(Vout_op*3) 'V'}));
    %fprintf(Oscillo, ':AUToscale');                                             % [Auto scale] key
    pause(1);
    
    %Scaling of CH2===========================================
    %fprintf(Oscillo, ':STOP');
    %pause(1);
    fprintf(Oscillo, ':MEASure:VMAX? CHANnel2');
    ch2_max = fscanf(Oscillo, '%f');
    fprintf(Oscillo, ':CHANnel2:RANGe?');
    ch2_scale = fscanf(Oscillo, '%f');

    if ch2_max < ch2_scale/2*0.1
        fprintf(Oscillo, strjoin({':CHANnel2:RANGe' num2str(ch2_max*3) 'V'}));
        pause(wait_cycles*6/Freq_List(j));
        fprintf(Oscillo, ':SINGle');
        %Wait for "Stop"
        fprintf(Oscillo, 'OPERegister:CONDition?');
        isBusy = fscanf(Oscillo, '%f');
        isBusy = dec2bin(isBusy, 12);
        while isBusy(9) == '1'
            pause(0.5);
            fprintf(Oscillo, 'OPERegister:CONDition?');
            isBusy = fscanf(Oscillo, '%f');
            isBusy = dec2bin(isBusy, 12);
        end
        
    else
        while ch2_max > ch2_scale/2*0.9 && ch2_scale < 40
            fprintf(Oscillo, strjoin({':CHANnel2:RANGe' num2str(ch2_scale*2) 'V'}));
            pause(wait_cycles*6/Freq_List(j));
            fprintf(Oscillo, ':SINGle');
            %Wait for "Stop"
            fprintf(Oscillo, 'OPERegister:CONDition?');
            isBusy = fscanf(Oscillo, '%f');
            isBusy = dec2bin(isBusy, 12);
            while isBusy(9) == '1'
                pause(0.5);
                fprintf(Oscillo, 'OPERegister:CONDition?');
                isBusy = fscanf(Oscillo, '%f');
                isBusy = dec2bin(isBusy, 12);
            end
            
            fprintf(Oscillo, ':MEASure:VMAX? CHANnel2');
            ch2_max = fscanf(Oscillo, '%f');
            fprintf(Oscillo, ':CHANnel2:RANGe?');
            ch2_scale = fscanf(Oscillo, '%f');
            fprintf(Oscillo, ':SINGle');
        end
    end
    
    pause(wait_cycles*6/Freq_List(j));
    fprintf(Oscillo, ':SINGle');
    %Wait for "Stop"
    fprintf(Oscillo, 'OPERegister:CONDition?');
    isBusy = fscanf(Oscillo, '%f');
    isBusy = dec2bin(isBusy, 12);
    while isBusy(9) == '1'
        pause(0.5);
        fprintf(Oscillo, 'OPERegister:CONDition?');
        isBusy = fscanf(Oscillo, '%f');
        isBusy = dec2bin(isBusy, 12);
    end
    
    %Read data=====================================
    fprintf(Oscillo, ':WAVeform:SOURce CHANnel2');
    fprintf(Oscillo, ':WAVeform:PREamble?');
    preamble = fscanf(Oscillo, '%f,%f,%f,%f,%f,%f,%f,%f,%f,%f');

    x_increment = preamble(5);
    x_origin = preamble(6);
    y_increment = preamble(8);
    y_origin = preamble(9);
    y_reference = preamble(10);

    fprintf(Oscillo, ':WAVeform:DATA?'); 
    ch_data = binblockread(Oscillo, 'uint8');
    ch_data = ch_data(11:end);
    analog_output = ((ch_data-y_reference).*y_increment)+y_origin; 
    time_output = x_origin + x_increment*(1:length(analog_output));
    
    out_sin = mean(analog_output.*sin(2*pi*Freq_List(j)*time_output)');
    out_cos = mean(analog_output.*cos(2*pi*Freq_List(j)*time_output)');
    
    Amp_List(j) = sqrt(out_sin^2+out_cos^2)*2/Vout_op;
    Pha_List(j) = 180/pi*atan2(out_cos, out_sin);
    fprintf(Oscillo, '*CLS');  
end

fprintf(Oscillo, ':WGEN:OUTPut 0');
fclose(Oscillo);

result.frequency = Freq_List;
result.amplitude = Amp_List;
result.phase = Pha_List;
