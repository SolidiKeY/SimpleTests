// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract EvaluationOrder {
    uint[] vec;

    function testEvaluationAfter() public {
        uint i = 0;
        delete vec;
        vec.push(1);
        vec.push(2);

        vec[i++] = vec[i];

        assert(vec[0] == 1);
        assert(vec[1] == 2);
    }

    function testEvaluationBefore() public {
        uint i = 0;
        delete vec;
        vec.push(1);
        vec.push(2);

        vec[++i] = vec[i];

        assert(vec[0] == 1);
        assert(vec[1] == 1);
    }

    function testEvaluationBothLeft() public {
        uint i = 0;
        delete vec;
        vec.push(100);
        vec.push(100);
        vec.push(100);

        vec[++i] = ++i;

        assert(vec[2] == 1);
    }

    function testEvaluationBothRight() public {
        uint i = 0;
        delete vec;
        vec.push(100);
        vec.push(100);

        vec[i++] = i++;

        assert(vec[1] == 0);
    }

    function testEvaluationBothRightLeft() public {
        uint i = 0;
        delete vec;
        vec.push(100);
        vec.push(100);
        vec.push(100);

        vec[++i] = i++;

        assert(vec[2] == 0);
    }

    function testEvaluationBothRightLeft2() public {
        uint i = 0;
        delete vec;
        vec.push(100);
        vec.push(100);
        vec.push(100);

        vec[i++] = ++i;

        assert(vec[1] == 1);
    }
}
