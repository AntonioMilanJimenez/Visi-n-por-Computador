function [y,v] = acquire(video_file)

if ischar(video_file),
    display(['Loading file ' video_file]);
    v = VideoReader(video_file);
else
    v = video_file;
end

numFrames = v.NumberOfFrames;

display(['Total frames: ' num2str(numFrames)]);

y = zeros(3, numFrames);
for i=1:numFrames,
    display(['Processing ' num2str(i) '/' num2str(numFrames)]);
    frame = read(v, i);
    
    %Se obtiene las 3 bandas del frame
    redPlane = frame(:, :, 1);
    greenPlane = frame(:, :, 2);
    bluePlane = frame(:, :, 3);
    
    %Se calcula la media para las 3 bandas
    y(1,i) = sum(sum(redPlane)) / (size(frame, 1) * size(frame, 2));
    y(2,i) = sum(sum(greenPlane)) / (size(frame, 1) * size(frame, 2));
    y(3,i) = sum(sum(bluePlane)) / (size(frame, 1) * size(frame, 2));
end

    %Se normalizan las bandas
    y(1,:) = normalize(y(1,:));
    y(2,:) = normalize(y(2,:));
    y(3,:) = normalize(y(3,:));
    
    %Se multiplica por su transpuesta
    X = y*transpose(y);

    %Obtenemos los autovectores y autovalores
    [A, D] = eig(X);

    %Se obtiene el autovector de mayor autovalor
    m = max(max(D));
    [f,c] = find(D==m);
    V = A(:,c);
    V = transpose(V);

    %Para obtener ya la señal se resta la media y se multiplica por el
    %autovector de mayor autovalor.
    y = V*(y-mean(transpose(y(:))));


display('Signal acquired.');
display(' ');
display(['Sampling rate is ' num2str(v.FrameRate) '. You can now run process(your_signal_variable, ' num2str(v.FrameRate) ')']);

end