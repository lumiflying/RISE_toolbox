function theta_=latin_hypercube(n,K,lb,ub,center)
if nargin<5
    center=true;
end
batch=linspace(0,1,K+1);
control=true(n,K);
seq=nan(n,K);
for k=1:K
    for ii=1:n
        avail=find(control(ii,:));
        interv=avail(randi(numel(avail),1));
        control(ii,interv)=false;
        low=batch(interv);
        high=batch(interv+1);
        if center
            seq(ii,k)=.5*(low+high);
        else
            seq(ii,k)=low+rand*(high-low);
        end
    end
end
theta_=bsxfun(@plus,lb,bsxfun(@times,ub-lb,Seq));

end
