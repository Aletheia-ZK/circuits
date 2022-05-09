circom ../../IdentityTree.circom --sym --wasm --r1cs -o ./plonk_example

node ./plonk_example/IdentityTree_js/generate_witness.js ./plonk_example/IdentityTree_js/IdentityTree.wasm example_input.json ./plonk_example/witness.wtns

snarkjs plonk setup ./plonk_example/IdentityTree.r1cs ../pot17_final.ptau ./plonk_example/IdentityTree_final.zkey

snarkjs zkey export verificationkey ./plonk_example/IdentityTree_final.zkey ./plonk_example/IdentityTree_verification_key.json

snarkjs plonk prove ./plonk_example/IdentityTree_final.zkey ./plonk_example/witness.wtns ./plonk_example/proof.json ./plonk_example/public.json

snarkjs plonk verify ./plonk_example/IdentityTree_verification_key.json ./plonk_example/public.json ./plonk_example/proof.json
