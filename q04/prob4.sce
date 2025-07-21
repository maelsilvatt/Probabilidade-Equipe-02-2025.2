// Questão a - Geração das amostras e cálculo das médias
A = grand(1200, 800, "uin", 0, 6);
mediaA = mean(A, "c");
desvioA = stdev(A, "c");

// Questão b - Cálculo dos intervalos de confiança
intervalos90 = zeros(1200, 2);
intervalos95 = zeros(1200, 2);
intervalos99 = zeros(1200, 2);

for i = 1:1200
    intervalos90(i, 1) = mediaA(i, 1) - (1.645 * desvioA(i, 1) / sqrt(800));
    intervalos95(i, 1) = mediaA(i, 1) - (1.960 * desvioA(i, 1) / sqrt(800));
    intervalos99(i, 1) = mediaA(i, 1) - (2.576 * desvioA(i, 1) / sqrt(800));
    
    intervalos90(i, 2) = mediaA(i, 1) + (1.645 * desvioA(i, 1) / sqrt(800));
    intervalos95(i, 2) = mediaA(i, 1) + (1.960 * desvioA(i, 1) / sqrt(800));
    intervalos99(i, 2) = mediaA(i, 1) + (2.576 * desvioA(i, 1) / sqrt(800));
end

// Questão c - Verificação do percentual dos intervalos que contêm a média real
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

porcentagem90 = acertos90 / 1200 * 100;
porcentagem95 = acertos95 / 1200 * 100;
porcentagem99 = acertos99 / 1200 * 100;

disp("Porcentagem de intervalos que contém a média real (3):");
disp("90% de confiança: " + string(porcentagem90) + "%");
disp("95% de confiança: " + string(porcentagem95) + "%");
disp("99% de confiança: " + string(porcentagem99) + "%");
