const RevertContract = artifacts.require("RevertContract");

async function getAllNames() {
  const revertInstance = await RevertContract.deployed();
  return Object.keys(revertInstance).filter(key => key.startsWith("testRevert"));
}

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

async function verify(){
  var keys = await getAllNames();
  keys.forEach(key =>{
    it(`Check the function ${key} reverts`, testRevert(key));
  })
}

contract("RevertContract", function (/* accounts */) {
  verify();
});
