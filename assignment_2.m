close all;
N = [0, 32, 48];
beta = [0, 0.35, 0.1];

M = 8;
no_of_filters = length(beta);
fft_size = 2048;
two_tap = 0;

% Color Scheme for Plotting
color = rand(M,3);

% Generating a Gaussian White Noise as input to Fitler Bank
x_length = 128;
x = wgn(1, x_length, 0);

for i = 1:no_of_filters
    if i == 1
        [h] = two_tap_filter();
        two_tap = 1;
    else
        [h] = raised_cosine_filter(N(i), beta(i));
        two_tap = 0;
    end
    [H] = analysis_bank(h, M);
    analysis_hermitial = H*H';
    [G] = synthesis_bank(h, M);
    synthesis_hermitian = G*G';
    
    % Input Signal through the PFRB
    [y, Y] = m_channel_filter_bank(x, M, H, G);
    visualise_filter_bank(H, G, x, y, Y, M, two_tap, N(i), beta(i), fft_size, color, i);
end



