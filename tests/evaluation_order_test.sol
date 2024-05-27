// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "remix_tests.sol"; // this import is automatically injected by Remix.
import "hardhat/console.sol";
import "../contracts/storage.sol";

contract EvaluationOrderTest {
    uint[] vec;

    function testEvaluationAfter() public {
        uint i = 0;
        delete vec;
        vec.push(1);
        vec.push(2);

        vec[i++] = vec[i];

        Assert.equal(vec[0], 1, "i is executed after line");
        Assert.equal(vec[1], 2, "i is executed after line");
    }

    function testEvaluationBefore() public {
        uint i = 0;
        delete vec;
        vec.push(1);
        vec.push(2);

        vec[++i] = vec[i];

        Assert.equal(vec[0], 1, "i is executed before line");
        Assert.equal(vec[1], 1, "i is executed before line");
    }

    function testEvaluationBothLeft() public {
        uint i = 0;
        delete vec;
        vec.push(100);
        vec.push(100);
        vec.push(100);

        vec[++i] = ++i;

        Assert.equal(vec[2], 1, "Evaluation in right before");
    }

    function testEvaluationBothRight() public {
        uint i = 0;
        delete vec;
        vec.push(100);
        vec.push(100);

        vec[i++] = i++;

        Assert.equal(vec[1], 0, "Evaluation in right before");
    }

    function testEvaluationBothRightLeft() public {
        uint i = 0;
        delete vec;
        vec.push(100);
        vec.push(100);
        vec.push(100);

        vec[++i] = i++;

        Assert.equal(vec[2], 0, "Evaluation in right before");
    }

    function testEvaluationBothRightLeft2() public {
        uint i = 0;
        delete vec;
        vec.push(100);
        vec.push(100);
        vec.push(100);

        vec[i++] = ++i;

        Assert.equal(vec[1], 1, "Evaluation in right before");
    }
}
