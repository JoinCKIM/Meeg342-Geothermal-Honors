function f = moody(ed,Re,verbose)

if Re<0
  error(sprintf('Reynolds number = %f cannot be negative',Re));
elseif Re<2000
  f = 64/Re;  return      %  laminar flow
end
if ed>0.05
  warning(sprintf('epsilon/diameter ratio = %f is not on Moody chart',ed));
end

findf = inline('1.0/sqrt(f) + 2.0*log10( ed/3.7 + 2.51/( Re*sqrt(f)) )','f','ed','Re');
fi = 1/(1.8*log10(6.9/Re + (ed/3.7)^1.11))^2;   %  initial guess at f
dfTol = 5e-6;
f = fzero(findf,fi,optimset('TolX',dfTol,'Display','off'),ed,Re);

end