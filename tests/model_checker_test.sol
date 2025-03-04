// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "remix_tests.sol"; // this import is automatically injected by Remix.
import "hardhat/console.sol";
import "../mc/simple_not_working_memory.sol";

contract MCTest {
    address addr;

    SimpleMemory mc;

    function beforeEach() public {
        mc = new SimpleMemory();
    }

    function testMemory() public {
        mc.testMemory();
    }

    function testDefault() public {
        mc.testDefault();
    }

    function testDefault2() public {
        mc.testDefault2();
    }

    function testMemoryComplex() public {
        mc.testMemoryComplex();
    }

    function testArray() public {
        mc.testArray();
    }

    function testDynamicVec() public {
        mc.testDynamicVec();
    }

    function testDynamicMatrix() public {
        mc.testDynamicMatrix();
    }

    function testMatrixRowCopy() public {
        mc.testMatrixRowCopy();
    }
}

