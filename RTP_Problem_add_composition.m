clc
x = [28, 19, 29, 19 ,1];




costs = [1000, 2000, 4000];
p_classies = [0.25 0.6 0.9];
p_rares = [0.021, 0.04261, 0.08];
p_heros = [3e-4, 6e-4, 1.814e-3];
p_legends = [3e-6, 6e-6, 1.5e-5];

i = 3;
cost = costs(i);

p_classy = p_classies(i);
p_rare = p_rares(i);
p_hero = p_heros(i);
p_legend= p_legends(i);
px = [1-p_classy, p_classy-p_rare, p_rare-p_hero, p_hero-p_legend, p_legend];

sell = [6, 50, 2500, 5e4, 10e5];


ppx = px./x;

p_refund_jackpot = 0.01;

expected_values = px.*sell*11;
expected_value = sum(expected_values);
N = sum(x);

pp = @(k) sum(ppx.^k.*(1-ppx).^(11-k));
p4 = pp(4);
p5 = pp(5);
p6 = pp(6);

cost_new1 = cost*(1-p_refund_jackpot);
cost_new2 = cost*(1-p_refund_jackpot)*(1-3*p4-5*p5-10*p6);
rtp = expected_value/cost_new1;





fprintf('   [기본사항]\n')
fprintf("뽑기비용 = %d 포인트. (%d포인트에 11회 뽑기)\n",cost, cost)
fprintf("변신 순서 : 일반 고급 희귀 영웅 전설\n")
fprintf("변신 등급별 갯수(종류) : %s\n", sprintf("%d ",x))
fprintf("변신 등급별 확률(종류별) : %s\n", sprintf("%.6f %%,  ",px*100))
fprintf("전체확률합 : %g\n",sum(px));
fprintf("변신 등급별 개당확률(종류별 각각) : %s\n", sprintf("%.6f %%,  ",ppx*100))
fprintf("변신 등급별 개당 가치 금액 : %s\n", sprintf('%d ',sell));

fprintf('\n\n   [고려요인]\n');
fprintf(' 1. 뽑기확률 & 판매가격. (고전적요인) \n 2. 잭팟고려\n')
%fprintf(' 3. 보너스게임고려\n')
fprintf('\n ii. 잭팟 고려방법 : 잭팟의 %.1f%%는 유저에게 돌려주는것이 확실하기때문에, 상품의 비용을 99.9%%로 계산하는것으로 (뽑기비용 %d원) 수학확률적 반영이됨\n',100*p_refund_jackpot,cost*(1-p_refund_jackpot));
%fprintf(' iii. 보너스게임 고려법 : 보너스게임의 확률을 계산하는것도 뽑기비용을 가감하는 방법으로 반영이됨. 뽑기비용 = 기존뽑기비용 * (보너스게임환산확률)\n\n')

% fprintf('11회차뽑기내에서 같은 변신이 4회 동시에 뽑힐 확률 : %.12f %%\n',p4*100)
% fprintf('11회차뽑기내에서 같은 변신이 5회 동시에 뽑힐 확률 : %.12f %%\n',p5*100)
% fprintf('11회차뽑기내에서 같은 변신이 6회 동시에 뽑힐 확률 : %.14f %%\n',p6*100)

fprintf('\n   [계산과정] \n');
fprintf(' 고전적 기댓값 : %f\n', expected_value)
fprintf(' 고전적 뽑기비용 : %f\n', cost);
fprintf(' 요인 1+2까지 반영한 실질적 뽑기비용 : %f\n', cost_new1);
%fprintf(' 요인 1+2+3까지 반영한 실질적 뽑기비용 : %f\n', cost_new2)
fprintf(' RTP = 고전적 기댓값 / 실질적 뽑기비용 : %f / %f = %f = %f %%\n',expected_value, cost_new2, rtp, rtp*100)

fprintf('\n [합성확률] \n')
fprintf(' %.4f %%    ',sell(1:end-1)./sell(2:end)*4*rtp*100)
fprintf('\n')