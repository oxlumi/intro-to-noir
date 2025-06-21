import { Noir } from "@noir-lang/noir_js";
import { ethers} from "ethers";
import { UltraHonkBackend } from '@aztec/bb.js'
import { fileURLToPath } from "url";
import path from "path";
import fs from "fs";

// get the circuit file with the bytecode.

const circuitPath = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "../../circuits/target/zk_panagram.json");
const circuit = JSON.parse(fs.readFileSync(circuitPath, "utf8"));

// Concepts: async functions and promises -> you can use await till you get the result
export default async function generateProof() {
    const inputsArray = process.argv.slice(2);
    try {
        const noir = new Noir(circuit);
        const bb = new UltraHonkBackend(circuit.bytecode, {threads:1});
        const inputs = {
            // Private Inputs
            guess_hash: inputsArray[0],
            // Public Inputs
            answer_hash: inputsArray[1],
        }
        
        const {witness} = await noir.execute(inputs);
        const {proof} = await bb.generateProof(witness, {keccak: true});

        // we need to abi encode the proof
        const proofEncoded = ethers.AbiCoder.defaultAbiCoder().encode(["bytes"], [proof]);

        return proofEncoded;
    }
catch (error){
    console.error("Error:", error);
}
}

{
    (async () => {
generateProof()
.then((proof) => {})
    })();
}



// initialize Noir with the circuit

// initialize the backend using the circuit bytecode
// create the inpus
// Execute the circuit with the inputs to create the witness
// generate the proof (using the backend with the witness
// return the proof 
 
// https://getfoundry.sh/reference/cheatcodes/ffi/ -> Allows you to run commands 




