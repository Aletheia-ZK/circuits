circom ../../ReputationTree.circom --sym --wasm --r1cs -o ./plonk_example

snarkjs plonk setup ./plonk_example/ReputationTree.r1cs ../pot15_final.ptau ./plonk_example/ReputationTree_final.zkey

snarkjs zkey export verificationkey ./plonk_example/ReputationTree_final.zkey ./plonk_example/ReputationTree_verification_key.json
