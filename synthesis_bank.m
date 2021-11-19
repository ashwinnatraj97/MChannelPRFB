function [G] = synthesis_bank(h_lpf, M)
    % To find the Number of Cascaded Filters
    k = log2(M);
    % Create High Pass Half Band Filter from Low Pass Half Band Filter
    h_hpf=(-1).^(0:(length(h_lpf)-1)).*h_lpf;
    % In the Synthesis Side, the Half Band High Pass Filter is the negative
    % sign of Half Band High Pass Filter in the analysis side
    h_hpf = h_hpf.*-1;
    % Generate the Interpolation Factors based on the Channel Size
    s = 1*2.^(0:k-1);

    % Storing Interpolated versions of Half Band Filters in a Cell of variable
    % size
    for i = 1:length(s)
        inter = zeros(1, s(i)*length(h_lpf));
        inter(1,1:s(i):s(i)*length(h_lpf)) = h_lpf;
        h_inter_lpf{i} = inter;

        inter(1,1:s(i):s(i)*length(h_hpf)) = h_hpf;
        h_inter_hpf{i} = inter;
    end

    for i = 1:M
        % Getting Band Pass Filter Index
        bin = dec2bin(i-1,k) - '0';

        % Iterating through the Binary Value of Index to choose Low/High Pass
        % Filter
        for k = 1:length(bin)
            % Storing the Half Band Filters in placeholders for easier
            % convolution
            if bin(k) == 0
                h = h_inter_lpf;
            else
                h = h_inter_hpf;
            end

            if k == 1
                % Storing h[n] as the initial value 
                % for subsequent convolutions
                bank_entry = h{1,1};
            else
                % Creating the Filter Bank convolving the appropritate
                % Half Band filter and the previous result
                bank_entry = conv(bank_entry, h{1, k});
            end 
        end
    G(i,:) = bank_entry;
    end
end