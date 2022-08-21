# Leading-Zero Counting

Три реализации счетчика ведущих нулей для блоков FPU. Одна из основных операций в тракте данных блоков с плавающей точкой является нормализация. При нормализации результат операции с плавающей точкой приводится к нормализованной форме, т.е. 1.xxx..x, где x ∈ {0, 1}. Нормализация включает использование блока подсчета ведущих нулей (ZLC). Организация устройст на основе статьи Low-Power Leading-Zero Counting and Anticipation Logic for High-Speed Floating Point Units // Giorgos Dimitrakopoulos, Kostas Galanopoulos, Christos Mavrokefalidis, Dimitris Nikolos.

![](./pic/classic.png)
*Classic algorithm*

![](./pic/proposed.png)
*Proposed algorithm*

![](./pic/second.png)
*Second algorithm*

