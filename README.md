# Polynomial_Function_Approximator
This project implements a polynomial approximator to fit an unknown nonlinear function using polynomial regression. The goal is to find an optimal polynomial degree m to best approximate a function based on noisy input-output data. The model is trained using a least-squares approach and evaluated on a separate validation dataset.
# Methodology
Polynomial Regression: A polynomial of degree m is used to approximate the unknown function.
Basis Functions: The regression model is based on powers of x1 and x2, as well as their interactions (e.g., x1^2, x1*x2, x2^2).
Model Evaluation: The model is evaluated using the Mean Squared Error (MSE) for both training and validation datasets.
Visualization: Various plots, including MSE comparison and 3D mesh plots, are generated to illustrate the fit and error for different polynomial degrees.
# Files
proj_fit_04.mat: The dataset file containing the training and validation data.
Fitting an unknown function.m: The main script implementing the polynomial regression.
# Results
Polynomial Degree Selection: The optimal degree is chosen based on validation performance to avoid overfitting while achieving a good approximation.
