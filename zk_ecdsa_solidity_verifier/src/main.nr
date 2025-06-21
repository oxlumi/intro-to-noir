use dep::ecrecover;

fn main(
    pub_key_x: [u8; 32],
    pub_key_y: [u8; 32] ,
    signature: [u8; 64],
    hashed_message: [u8; 32], 
    expected_address: Field,
) {

    assert(pub_key_y[31] >= 0, "pub_key_y is not in the upper half of the curve");

    let address = ecrecover::ecrecover(pub_key_x, pub_key_y, signature,hashed_message);

    assert(address != 0, "Address is zero");
    assert(address == expected_address, "Address does not match");
}
