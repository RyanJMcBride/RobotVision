function posterior_belief = discrete_localise1d(prior_belief,signs_map,measur_prob,z)
% prior_belief: The prior belief of the robot about its location before incorporating any sensor information
% signs_map : the map of where the signs are in the hallway.
% measurements probabilities = [p(z=1|sign) , p(z=1|no_sign)]
% z is the detector output. 1 sign, 0 no_sign.

% posterior_belief = prior*likelihood

prior_belief = prior_belief;
signs_map =signs_map;
measur_prob =measur_prob;
z = z;

measur_prob_z = [1-measur_prob(1) 1-measur_prob(2)];
signs = sum(signs_map);
%if sign detected 

if z == 1
    wqer = (signs_map.*measur_prob(1))+(~signs_map.*measur_prob(2));
    Pz = sum(wqer.*prior_belief);
    posterior_belief = (wqer.*prior_belief)./Pz;
end
if z == 0
    
    wqer = (signs_map.*measur_prob_z(1))+(~signs_map.*measur_prob_z(2));
    Pz = sum(wqer.*prior_belief);
    posterior_belief = (wqer.*prior_belief)./Pz;
end
end
