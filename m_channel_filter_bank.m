function [y, Y] = m_channel_filter_bank(x, M, H, G)
y = 0;
% fft_size = 1024;
% domega=2*pi/fft_size;
% omega=-pi:domega:pi-domega;

% Input Signal passes through the Analysis Filter Bank
for i = 1:M
    W(i,:) = conv(x, H(i,:));
    % Decimate each output of the filter bank by the order of the filter
    Z(i,:) = W(i, 1:M:length(W(i,:)));
end

% Frequency Domain Analysis of output of Analysis Filter Bank
% for i = 1:M
%     Z_w(i,:) = abs(fftshift(fft(Z(i,:),fft_size)));
% end

% figure('NumberTitle', 'off', 'Name', "Output of Analysis Filter Bank of Order "+ (M));
% hold on
% for i = 1:M
%     plot(omega,Z_w(i,:),'Color',[rand,rand,rand]);
% end
% hold off

% Output of Analysis Filter Bank passes through Synthesis Filter Bank
for i = 1:M
    % Creating a Vector of zeros as a placeholder before zero inserts
    V(i,:) = zeros(1, M*length(Z(i,:)));
    V(i,1:M:length(V(i,:))) = Z(i,:);
    % Convolution with the Synthesis Filter Bank
    Y(i,:) = conv(V(i,:),G(i,:));
end

% Summation of output of Synthesis Filter Bank
for i=1:M
    y = y+Y(i,:);
end

end