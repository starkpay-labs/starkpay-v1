%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.uint256 import Uint256
from openzeppelin.token.ERC20.library import ERC20
from openzeppelin.token.ERC721.library import ERC721
from starkware.starknet.common.syscalls import (
    get_block_number,
    get_block_timestamp,
)

@contract_interface
namespace IFactory {
    func param() -> (address: felt) {
    } 
}

//structs
struct Token{
    balance : Uint256,
    totalPaidPerSec : Uint256,
    divisor: Uint256,
    lastUpdate: Uint256
}

struct Stream{
    starts: Uint256,
    end: Uint256,
    amountPerSec: Uint256,
    lastPaid: Uint256,
    token: felt
}

@storage_var
func owner() -> (address: felt) {
}

@storage_var
func nextTokenId() -> (res: Uint256) {
}

// Mappigs
@storage_var
func streams(id: felt) -> (stream: Stream) {
}

@storage_var
func tokens(address: felt) -> (token: Token) {
}

@storage_var
func payerWhitelists(address: felt) -> (res: Uint256) {
}

@storage_var
func redirects(address: felt) -> (address: felt) {
}

// nested mappings
@storage_var
func streamWhitelists() -> (res: felt) {
}

@storage_var
func debts(key: Uint256) -> (value: Uint256) {
}

@storage_var
func redeemables(key: Uint256) -> (res: Uint256) {
}

// Events
@event
func Deposit(
    token: felt,
    from: felt,
    amount: Uint256
) {
}

@event 
func WithdrawPayer(
    token: felt,
    to: felt,
    amount: Uint256
) {
}

@event
func Withdraw(
    id: Uint256
    token: felt,
    to: felt,
    amount: Uint256
) {
}

@event
func CreateStream(
    id: Uint256,
    token: felt,
    to: felt,
    amountPerSec: Uint256,
    starts: Uint256,
    ends: Uint256
) {
}

@event
func CreateStreamWithReason(
    id: Uint256,
    token: felt,
    to: felt,
    amountPerSec: Uint256,
    starts: Uint256,
    ends: Uint256,
    reason: felt
) {
}

@event
func CreateStreamWithheld(
    id: Uint256,
    token: felt,
    to: felt,
    amountPerSec: Uint256,
    starts: Uint256,
    ends: Uint256,
    withheldPerSec: Uint256
) {
}

@event
func CreateStreamWithheldWithReason(
    id: Uint256,
    token: felt,
    to: felt,
    amountPerSec: Uint256,
    starts: Uint256,
    ends: Uint256,
    withheldPerSec: Uint256,
    string: felt
) {
}

@event 
func AddPayerWhitelist(
    whitelisted: felt
) {
}

@event
func RemovePayerWhitelist(
    removed: felt
) {
}

@event 
func AddRedirectStream( 
    id: Uint256, 
    redirected: felt
) {
}

@event
func RemoveRedirectStream(
    id: Uint256
) {
}

@event 
func AddStreamWhitelist(
    id: Uint256,
    whitelisted: felt
) {
}

@event 
func RemoveStreamWhitelist(
    id: Uint256, 
    removed: felt
) {
}

@constructor
func constructor{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    name: felt, symbol: felt
) {
    ERC721.initializer(name, symbol);
    owner.write();
    return();
}

@external
func createStream{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    _token: felt,
    _to: felt,
    _amountPerSec: Uint256, 
    _starts: Uint256, 
    _ends: Uint256
) {
   let (id: Uint256) = _createStream(_token, _to, _amountPerSec, _starts, _ends);
   CreateStream.emit(id, _token, _to, _amountPerSec, _starts, _ends);
   return ();
}

// @external
// func createStreamWithReason{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
//     _token: felt,
//     _to: felt,
//     _amountPerSec: Uint256, 
//     _starts: Uint256, 
//     _ends: Uint256,
//     _reason: felt
// ) {
//     let (id: Uint256) = _createStream(_token, _to, _amountPerSec, _starts, _ends);
//     createStreamWithReason.emit(id, _token, _to, _amountPerSec, _starts, _ends, _reason);
// }

// @external
// func createStreamWithheld{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
//     _token: felt,
//     _to: felt,
//     _amountPerSec: Uint256, 
//     _starts: Uint256, 
//     _ends: Uint256,
//     _withheldPerSec: Uint256
// ) {
//     let (id: Uint256) = _createStream(_token, _to, _amountPerSec, _starts, _ends);
//     createStreamWithheld.emit(id, _token, _to, _amountPerSec, _starts, _ends, _withheldPerSec);
// }

// @external
// func modifystream{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
//     _id: Uint256,
//     _newAmountPerSec: Uint256,
//     _newEnd: Uint256,
//     _payDebt: felt
// ) {
    
// }

func _createStream{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    _token: felt,
    _to: felt,
    _amountPerSec: Uint256, 
    _starts: Uint256, 
    _ends: Uint256
) {
    
    with_attr error_message("zero address not allowed") {
        assert_not_zero(_to);
    }

    with_attr error_message("invalid start and end time") {
        assert_le(end, _starts);
    }

    let (block_timestamp) = get_block_timestamp();
    with_attr error_message("Payer in indebt") {
        assert_le(tokens[_token].lastUpdate,block_timestamp);
    }

    let (id: Uint256) = nextTokenId.read();

    // Handles if start is before stream creation
    // To pay amount missed before stream creation

    if (block_timestamp > _starts) {

        let (owed: Uint256) = (block_timestamp - _starts)*(_amountPerSec);
        let (balance: Uint256) = tokens.read(_token).balance;

        if (balance >= owed) { 











}




