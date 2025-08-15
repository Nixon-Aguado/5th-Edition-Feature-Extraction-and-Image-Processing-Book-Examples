function measures=basic_texture(pic)
measures(1:3)=0;
Fpic=fft2(pic);
normFpic=normalise_coeffs(Fpic);
%entropy
measures(1)=calc_entropy(normFpic);
%inertia
measures(2)=calc_inertia(normFpic);
%energy
measures(3)=calc_energy(normFpic);
end

            