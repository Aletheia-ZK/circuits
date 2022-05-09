circom ../../IdentityTree.circom ---r1cs --wasm -o ./groth_example

node IdentityTree_js/generate_witness.js groth_example/IdentityTree_js/IdentityTree.wasm example_input.json groth_example/witness.wtns

# Phase 1
snarkjs powersoftau new bn128 17 groth_example/pot12_0000.ptau -v

snarkjs powersoftau contribute groth_example/pot12_0000.ptau groth_example/pot12_0001.ptau --name="First contribution" -v

# Phase 2
snarkjs powersoftau prepare phase2 groth_example/pot12_0001.ptau groth_example/pot12_final.ptau -v

snarkjs groth16 setup IdentityTree.r1cs groth_example/pot12_final.ptau groth_example/IdentityTree_0000.zkey

# Contribute to Phase 2
snarkjs zkey contribute groth_example/IdentityTree_0000.zkey groth_example/IdentityTree_0001.zkey --name="1st Contributor Name" -v

# Export verification key
snarkjs zkey export verificationkey groth_example/IdentityTree_0001.zkey groth_example/verification_key.json

# Generate proof
snarkjs groth16 prove groth_example/IdentityTree_0001.zkey groth_example/witness.wtns groth_example/proof.json groth_example/public.json

# Verify proof
snarkjs groth16 verify groth_example/verification_key.json groth_example/public.json groth_example/proof.json