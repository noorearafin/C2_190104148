I = imread('random.png');
sigma = input('Enter Sigma value: ');
figure;
subplot(1, 2, 1);
imshow(I);

X =[-1 0 1;
    -1 0 1;
    -1 0 1];

Y = X.';
K = zeros(3, 3);
for i = 1:3
    for j = 1:3
        K(i, j) = (1 / (2 * pi * sigma^2)) * exp((-(X(i, j)^2 + Y(i, j)^2)) / (2 * sigma^2));
    end
end

K = K / sum(K(:));

I = padarray(I, [1 1], 'replicate');
I = double(I);
[row, col] = size(I);
[krow, kcol] = size(K);

for i = 1:row - krow+1
    for j = 1:col - kcol+1
        w = I(i:i + krow-1, j:j + kcol-1);
        I(i+round(krow / 2)-1, j+round(kcol / 2)-1) = sum(w( : .* K(:));
    end
end

I = uint8(I);
subplot(1,2,2);
imshow(I);
imwrite(I, 'gaussian_output.jpg');