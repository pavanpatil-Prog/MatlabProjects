function result=ofdm_demod_gui(data,bits_per_symbol)
global result_plot;
%result=fftshift(data);
result_plot=fft(data);
%scatterplot(reshape(result,1,...
  %  size(result,1)*size(result,2)));
%demodulating PSKdata
%result=real(result);
result=result_plot([7:32;34:59],:);
result=pskdemod(result,2^bits_per_symbol);
%result=real(result);
result=reshape(result,1,...
    size(result,1)*size(result,2));
