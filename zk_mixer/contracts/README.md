# ZK Mixer Project

- Deposit: users can deposit ETH into the mixer to break the connection between depositor and withdrawer.
- Withdraw: users will withdraw using a ZK proof (Noir, generated offchain) of knowledge of their deposit.

## Proof
- Check that the commitment is present in the Merkle tree
 - Inputs: proposed root and Merkle proof

- Check the nullifier matches the public nullifier hash

### Private Inputs
- Secret
- Nullifier
- Merkle proof (so we can reconstruct)
- Boolean to say whether the node pass a given index.

### Public Inputs
- Proposed root
- Nullifier hash