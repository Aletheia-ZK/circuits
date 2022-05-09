pragma circom 2.0.3;

include "./circomlib/circuits/poseidon.circom";
include "./MerkleTree.circom";


// identity = hash(password + publicAddr)
// output = hash(publicAddr)

// Merkle Tree Inclusion Proof
// output = hash(publicAddr)

// authID = hash(publicAddr) => website can use it as auth token
// secret = password

// Attack #1: user submits merkle tree proof of another account
// Defense: connect both proofs through public addre

// Attack #2: user submits old merkle tree proof
// Defense: root of merkle tree is stored publicly on blockchain => website can check how wold root is

// Attack #3: user creates entry in Semaphore for a public addr without owning the public addr
// => Defense: ?

// Attack #4: user creates several entries in the semaphore and spams the website
// => Defense: ?

// I don't need nullifiers is that right?

template IdentityInclusionProof(nLevels) {

		signal input password;
		signal input publicAddr;
		signal input pathIndices[nLevels];
    signal input siblings[nLevels];
		signal output root;
    signal output id;

    component hasher = Poseidon(2);
    signal identityCommitment;
    hasher.inputs[0] <== publicAddr;
    hasher.inputs[1] <== password;
    identityCommitment <== hasher.out;

    component inclusionProof = MerkleTreeInclusionProof(nLevels);
    inclusionProof.leaf <== identityCommitment;

    for (var i = 0; i < nLevels; i++) {
        inclusionProof.siblings[i] <== siblings[i];
        inclusionProof.pathIndices[i] <== pathIndices[i];
    }

    root <== inclusionProof.root;

    component idHasher = Poseidon(1);
    idHasher.inputs[0] <== publicAddr;
    id <== idHasher.out;

}

component main = IdentityInclusionProof(10);