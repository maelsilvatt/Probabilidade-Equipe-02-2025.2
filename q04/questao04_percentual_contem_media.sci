acertos90 = 0;
acertos95 = 0;
acertos99 = 0;
for i = 1:1200
    if 3 > intervalos90(i, 1) & 3 < intervalos90(i, 2) then
        acertos90 = acertos90 + 1;
    end
    if 3 > intervalos95(i, 1) & 3 < intervalos95(i, 2) then
        acertos95 = acertos95 + 1;
    end
    if 3 > intervalos99(i, 1) & 3 < intervalos99(i, 2) then
        acertos99 = acertos99 + 1;
    end
end