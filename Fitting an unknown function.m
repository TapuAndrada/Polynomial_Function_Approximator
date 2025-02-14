clc
clear 
close all

data = load("proj_fit_04.mat");

X1_train = data.id.X{1};
X2_train = data.id.X{2};
Y_train = data.id.Y;

X1_val = data.val.X{1};
X2_val = data.val.X{2};
Y_val = data.val.Y;

for i = 1:25
    m = i;
    basis_functions = [];
    phi = [];
    phi_train = ComputePHI(m, X1_train, X2_train, phi, basis_functions);

    Y_hat_train = ComputeYHat(m, X1_train, X2_train, phi, basis_functions, Y_train);
    error_train = Y_train - Y_hat_train;
    mse_train(m) = ComputeMSE(error_train);

    Y_hat_val = ComputeYHat(m, X1_val, X2_val, phi, basis_functions, Y_val);
    error_val = Y_val - Y_hat_val;
    mse_val(m) = ComputeMSE(error_val);
end

m = 1:25;
figure("Name", "MSE Plot for Validation Data")
plot(m, mse_val, "-*")
min_mse_val = min(mse_val);

figure("Name", "Underfitting vs Overfitting")
plot(m, mse_val, "-*", 'Color', 'red')
hold on
plot(m, mse_train, "-*", 'Color', 'green')
legend('Validation Data Error', 'Training Data Error')

figure("Name", "Verification")
mesh(X1_val, X2_val, Y_val, 'EdgeColor', 'green')
hold on
mesh(X1_val, X2_val, ComputeYHat(20, X1_val, X2_val, phi, basis_functions, Y_val), 'EdgeColor', 'red')
legend('Unknown Function', 'Approximated Function')

function basis = ComputeBasisFunctions(m, x1, x2, basis)
    for i = 0:m
        basis = [basis; (x1.^(m-i) .* x2.^i)]; % Add row
    end   
end

function phi = ComputePHI(m, x1, x2, phi, basis)
    for i = 1:m+1
        phi = [phi; ComputeBasisFunctions((i-1), x1, x2, basis)];    
    end
end

function y_hat = ComputeYHat(m, x1, x2, basis, phi, y)
    phi = ComputePHI(m, x1, x2, phi, basis)';
    theta = phi \ y;
    y_hat = phi * theta;
end

function mse = ComputeMSE(error)
    [N1, N2] = size(error);
    mse = 0;
    for i = 1:N1
        for j = 1:N2
            mse = mse + ((1 / (N1 * N2)) * error(i, j)^2);  
        end
    end
end
