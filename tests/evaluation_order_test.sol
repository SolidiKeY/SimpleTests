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
        // vec[i] = vec[i]; vec[0] = vec[0];
        // i++;

        Assert.equal(vec[0], 1, "i is executed after line");
        Assert.equal(vec[1], 2, "i is executed after line");
    }

    function testEvaluationBefore() public {
        uint i = 0;
        delete vec;
        vec.push(1); // vec[0] == 1
        vec.push(2); // vec[1] == 2

        vec[++i] = vec[i];
        // vec[1] = vec[0];

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

    function testRightIpp() public {
        uint i = 0;
        uint j = 0;

        j = 5/i + ++i;

        Assert.equal(j, 6, "Evaluation ++i before dividing");
    }

    function testRightIppRight() public {
        uint i = 0;
        uint j = 0;

        // j = ++i + 5/i ;
        // it will throw an error for division by zero
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
