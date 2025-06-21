// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test, console2} from "forge-std/Test.sol";
import {Panagram} from "../src/Panagram.sol";
import {HonkVerifier} from "../src/Verifier.sol";


contract PanagramTest is Test {
    // Deploy the Verifier
    // Deploy the panagram contract
    // Create the answer
    // Start the round
    // Make a guess
    HonkVerifier public verifier;
    Panagram public panagram;
    // The field modulus used in the ZK-SNARKs (copied from Verifier.sol or a shared constants file)
    uint256 constant FIELD_MODULUS = 21888242871839275222246405745257275088548364400416034343698204186575808495617; // We can check this in the Verifier.sol file
    bytes32 public ANSWER = bytes32(uint256(keccak256(bytes("triangles"))) % FIELD_MODULUS); // Will store the processed answer for the round
    address public USER = makeAddr("user");
    /* > Creating the ZK-Compatible Answer:
   This is a critical step when integrating Solidity contracts with ZK-SNARK circuits, such as those written in Noir.

   * **Noir Circuit Expectation:** The Noir circuit for Panagram (likely in `src/main.nr`) expects the `answer_hash` as a `Field` element.

   * **Solidity Hashing:** `keccak256` in Solidity produces a 256-bit hash (a `bytes32` value).

   * **Field Modulus Constraint:** A `Field` element in Noir (specifically for the BN254 curve, commonly used with Aztec tooling) is constrained by a prime field modulus. This `FIELD_MODULUS` (which we defined as `21888242871839275222246405745257275088548364400416034343698204186575808495617`) is smaller than the maximum value representable by a 256-bit integer.

   * **The Solution: Modular Arithmetic:** To make the Solidity hash compatible, we must reduce it modulo the `FIELD_MODULUS`. This ensures the hash value fits within the range expected by the Noir circuit.

   The process is:

   1. Choose a secret answer string (e.g., "triangles").
   2. Hash this string using `keccak256`. It's best practice to hash the byte representation: `keccak256(bytes("triangles"))`.
   3. Convert the resulting `bytes32` hash to a `uint256`.
   4. Apply the modulo operation: `uint256_hash % FIELD_MODULUS`.
   5. Convert this result back to `bytes32` and store it in our `ANSWER` state variable.
    */


    function setUp() public {
        verifier = new HonkVerifier();
        panagram = new Panagram(verifier);
        panagram.newRound(ANSWER);

    }
    function _getProof(bytes32 guess, bytes32 correctAnswer) internal returns (bytes memory) {
        uint256 NUMB_ARGS = 5;
        string[] memory inputs = new string[](NUMB_ARGS);
        inputs[0] = "npx";
        inputs[1] = "tsx";
        inputs[2] = "js-scripts/generateProof.ts";
        inputs[3] = vm.toString(guess);
        inputs[4] = vm.toString(correctAnswer);

        bytes memory result = vm.ffi(inputs);
    }

    // Test someone recieves NFT 0 if they guess correctly first
    function testCorrectGuessPasses() public {
        vm.prank(USER);
        


    }
    // Test someone recieves NFT 1 if they guess correctly second

    // Test we can start a new round.
}