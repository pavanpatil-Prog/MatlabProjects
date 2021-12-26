%clear all;
clc;
%Data type representingthat progam accepts maximum eight
initialization;
[height width]=size(data);
serial_data=reshape(data,1,(height*width));
serial_data=double(serial_data);
%Converting image data to its eqivalent symbol values.
qpsk_input=conversion(serial_data,word_size,symbol_size);
%Applying a modulation procedure
ofdm_data=ofdm_mod_gui(qpsk_input,symbol_size,no_of_carriers,no_of_datacarriers);
%figure(1);
%plot(freq_axis,real(ofdm_data),'k');
%axis([-sampling_freq/2 sampling_freq/2 -.3 .3]);
%Adding cyclic prefix as guard time.
ofdm_cp=vertcat(ofdm_data(49:64,:),ofdm_data);
%ofdm_cp=real(ofdm_cp);
%**************************************************************************
%**************************************************************************
%Adding white gaussian noise to the existing ofdm signal
%for i=1:size(ofdm_cp,2)
    corrupted_signal=awgn(ofdm_cp,12,'measured');
%end    
%Convert it serial for transmission
trans_data=reshape(corrupted_signal,1,size(corrupted_signal,1)*size(corrupted_signal,2));
save('transmitted_data.mat','trans_data','height','width');
%Flush all data as on transmitter side
%clear all
%**************************************************************************
%**************************************************************************
%RECEIVING DATA 
load('transmitted_data');
received_data=trans_data;
initialization;
received_data=reshape(received_data,ofdm_symbol_size,...
    (size(received_data,1)*size(received_data,2))/ofdm_symbol_size);
BaseBand_data=received_data(17:ofdm_symbol_size,:);
%plot(freq_axis,real(BaseBand_data),'k');
demod_data=ofdm_demod_gui(BaseBand_data,symbol_size);
demod_data=conversion(demod_data,symbol_size,word_size);
demod_data=demod_data(1:height*width);
received_file=reshape(demod_data,height,width);