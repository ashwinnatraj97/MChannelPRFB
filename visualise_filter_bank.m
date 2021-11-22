function visualise_filter_bank(H, G, x, y, Y, M, two_tap, N, beta, fft_size, color, index)    
    %Initialising FFT Properities
    domega=2*pi/fft_size;
    omega=-pi:domega:pi-domega;
    
    % Analysing the frequency content of x[n]
    X_w = abs(fftshift(fft(x,fft_size)));
    
    % Frequency content of Analysis Filter Bank
    for k = 1:M
        H_w(k,:) = abs(fftshift(fft(H(k,:),fft_size)));
    end
    
    % Visualising of the Analysis Filter Bank
    if two_tap == 1
            fig_title = "Perfect Reconstruction Filter Bank based on Two Tap Filter of the Order "+(M);
            prfb_fig = figure('NumberTitle', 'off', 'Name', fig_title);
            file_name = "PRFB_Two_tap";
    else
            fig_title = "Perfect Reconstruction Filter Bank based on Raised Cosine Filter of the Order "+(M)+" | Beta = "+(beta)+" | Length = "+(N);
            prfb_fig = figure('NumberTitle', 'off', 'Name', fig_title);
            file_name = "PRFB_RaisedCosine_N_" + num2str(N);
    end
    subplot(411)
    hold on
    for k = 1:M
        plot(omega,H_w(k,:),'Color',color(k,:));
    end
    axis([-pi pi 0 max(H_w(:))]);
    title((index)+"(a). Superimposed Frequency Response of each channel in the Analysis Filter Bank");
    hold off
    
    % Plotting the Frequency content of the input signal
    subplot(412)
    plot(omega,X_w);
    axis([-pi pi 0 max(X_w)]);
    title((index)+"(b). Frequency Content of White Gaussian Noise Input Signal");
    
    % Frequency content of Output of Synthesis Filter Bank
    for k = 1:M
        Y_w(k,:) = abs(fftshift(fft(Y(k,:),fft_size)));
    end
    
    % Visualising of the Output of Synthesis Filter Bank  
    subplot(414)
    hold on
    for k = 1:M
        plot(omega,Y_w(k,:),'Color',color(k,:));
    end
    axis([-pi pi 0 max(Y_w(:))]);
    title((index)+"(d). Superimposed Frequency Response of Output of each channel from the Synthesis Filter Bank");
    hold off
    
    % Visualising the Ouput of Fitler Bank
    Y_w = abs(fftshift(fft(y,fft_size)));
    subplot(413)
    plot(omega,Y_w);
    axis([-pi pi 0 max(Y_w)]);
    title((index)+"(c). Output of Perfect Reconstruction Filter Bank");
    saveas(prfb_fig, file_name,'epsc')
    
    analysis_hermitian = H*H';
    analysis_hermitian_latex = latex(sym(analysis_hermitian));
    file = fopen(file_name+"_analysis.tex",'w');
    fprintf(file,'%s',analysis_hermitian_latex);
    fclose(file);

    synthesis_hermitian = G*G';
    synthesis_hermitian_latex = latex(sym(synthesis_hermitian));
    file = fopen(file_name+"_synthesis.tex",'w');
    fprintf(file,'%s',synthesis_hermitian_latex);
    fclose(file);
end