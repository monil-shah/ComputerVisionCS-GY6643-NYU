function z = Function(dzdx,dzdy)
    
    if ~all(size(dzdx) == size(dzdy))
      error('Gradient matrices must match');
    end

    [rows,cols] = size(dzdx);
    

    [wx, wy] = meshgrid(([1:cols]-(fix(cols/2)+1))/(cols-mod(cols,2)), ...
			([1:rows]-(fix(rows/2)+1))/(rows-mod(rows,2)));
    

    wx = ifftshift(wx); wy = ifftshift(wy);

    DZDX = fft2(dzdx);   % Fourier transforms of gradients
    DZDY = fft2(dzdy);

    Z = (-j*wx.*DZDX -j*wy.*DZDY)./(wx.^2 + wy.^2 + eps);  % Equation 21
    
    z = real(ifft2(Z));  % Reconstruction
