function [xk_plus,Pk_plus]=My_WKF(rho,Fu,Qu_KF,Hu,Ru,xk_plus,Pk_plus,zk)
A_aug = [Fu;Hu*Fu];
B_aug = [eye(4) zeros(4,2);Hu eye(2)];
mu_t = A_aug * xk_plus;
Sigma_t = A_aug * Pk_plus * A_aug' + B_aug * [Qu_KF zeros(4,2);zeros(2,4) Ru] * B_aug';
[phi_star, Q_star] = F_W(mu_t, Sigma_t, rho, 4);
G_t = phi_star.G;
S_t = Q_star.Sigma;
Pk_plus = S_t(1:4, 1:4) - G_t * S_t(5:end, 1:4);
xk_plus = G_t*(zk - mu_t(5:end,1)) + mu_t(1:4,1);
end