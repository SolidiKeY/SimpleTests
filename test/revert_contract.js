const RevertContract = artifacts.require("RevertContract");

function testRevert(revertTerm) {
  return async () => {
    const revertInstance = await RevertContract.deployed();
    const revRevert = revertInstance[revertTerm];
    try{
      await revRevert.call();
    }
    catch{return;}
    assert.fail("The function should revert");
  }
}

contract("RevertContract", function (/* accounts */) {
  it("Check if contracts revert.", testRevert("shouldRevert"));
});
