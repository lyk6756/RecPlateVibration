# RecPlateVibration

Calculate the vibration modes of a rectangular plate with free-free boundary conditions by the Ritz method. The vibration shape functions and natural frequencies are given in the MATLAB program.

Application condition:
1. Boundary conditions are not symmetric about the diagonal, including square plates and rectangular plates;
2. Boundary conditions are symmetric about the diagonal, while length-width ratio has great difference.

Not suitable for use:
1. Square plates with boundary conditions symmetric about the diagonal;
2. Rectangular plates with length-width ratio near 1(0.8 < a/b < 1.25).

---

# 矩形平板振动

采用里茨法（双向梁函数组合级数逼近，单项组合法）计算自由-自由边界条件下矩形平板的振动模态，包括振型函数及固有频率。

适用情况：
1. 边界条件不以对角线为对称的板（包括方板、矩形板）；
2. 边界条件以对角线为对称的矩形板（两临边边长相差较大）。

不适用情况：
1. 边界条件以对角线为对称的方板；
2. 接近方形板的矩形板（0.8 < 长宽比 < 1.25）。
