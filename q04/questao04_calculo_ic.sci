// Questao b - Calculo dos intervalos de confianca
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