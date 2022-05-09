circom ../../ReputationTree.circom --sym --wasm --r1cs -o ./plonk_example

node ./plonk_example/ReputationTree_js/generate_witness.js ./plonk_example/ReputationTree_js/ReputationTree.wasm example_input.json ./plonk_example/witness.wtns

snarkjs plonk setup ./plonk_example/ReputationTree.r1cs ../pot17_final.ptau ./plonk_example/ReputationTree_final.zkey

snarkjs zkey export verificationkey ./plonk_example/ReputationTree_final.zkey ./plonk_example/ReputationTree_verification_key.json

snarkjs plonk prove ./plonk_example/ReputationTree_final.zkey ./plonk_example/witness.wtns ./plonk_example/proof.json ./plonk_example/public.json

snarkjs plonk verify ./plonk_example/ReputationTree_verification_key.json ./plonk_example/public.json ./plonk_example/proof.json
