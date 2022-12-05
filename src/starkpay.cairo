%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.uint256 import Uint256
from openzeppelin.token.ERC20.library import ERC20
from openzeppelin.token.ERC721.library import ERC721

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

