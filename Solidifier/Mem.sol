pragma solidity ^0.5.10;

library Verification {
    function Assert  (bool b) public;
    function Assume  (bool b) public;
    function CexPrinti  (uint i) public;
}

contract SimpleMemory {

    struct Account {
        int balance;
    }

    struct Person {
        int age;
        bool isMale;
        Account account;
    }

    function testMemory() public {
        Person memory alice;
        Person memory bob;

        alice.account.balance = 10;
        bob.account.balance = 20;
        Account memory acc = bob.account;

        alice.account = bob.account;
        Verification.Assert(acc.balance == 20);

        alice.account.balance = 30;
        Verification.Assert(alice.account.balance == 30);
        Verification.Assert(bob.account.balance == 30);
    }

    function testDefault() public {
        Person memory alice;
        Person memory bob;
        Verification.Assert(alice.account.balance == 0);

        bob.account.balance = 10;
        Verification.Assert(alice.account.balance == 0);
    }

    function testDefault2() public {
        Person memory alicee;
        Person memory bobb;
        Verification.Assert(alicee.account.balance == 0);

        bobb.account.balance = 10;
        bobb.account = alicee.account;
        Verification.Assert(bobb.account.balance == 0);
    }

    function testMemoryComplex() public {
        Person memory alice;
        Person memory bob;

        alice.account.balance = 10;
        bob.account.balance = 20;
        Account memory acc = bob.account;

        alice.account = bob.account;
        Verification.Assert(acc.balance == 20);

        acc.balance = 30;
        Verification.Assert(alice.account.balance == 30);
        Verification.Assert(bob.account.balance == 30);
    }

    function testShallowStruct() public {
        Person memory eve;
        Person memory carol;

        carol = eve;
        eve.age = 20;

        int v1 = carol.age;
        Verification.Assert(v1 == 20);
    }

    function testArray() public {
        Person[] memory friends = new Person[](10);
        friends[1] = friends[0];
        friends[0].age = 20;

        int friendAge1 = friends[1].age;
        Verification.Assert(friendAge1 == 20);
    }

    function testDynamicVec() public {
        int[] memory yearsVec;
        int[] memory numbers;

        numbers = yearsVec;
        yearsVec = new int[](10);

        uint numbersSize = numbers.length;
        Verification.Assert(numbersSize == 0);

        numbers = yearsVec;
        numbersSize = numbers.length;
        Verification.Assert(numbersSize == 10);

        yearsVec[0] = 1;
        int numbers0 = numbers[0];
        Verification.Assert(numbers0 == 1);
    }

    function testDynamicMatrix() public {
        int[][] memory matrix1;
        int[][] memory matrix2;

        matrix1 = new int[][](10);
        matrix2 = matrix1;

        uint v = matrix1.length;
        Verification.Assert(v == 10);

        matrix2[0] = new int[](2);
        matrix2[0][1] = 3;

        uint s10 = matrix1[0].length;
        Verification.Assert(s10 == 2);

        int v101 = matrix1[0][1];
        Verification.Assert(v101 == 3);
    }

    function testMatrixRowCopy() public {
        int[][5] memory matrix;

        matrix[0] = new int[](10);
        matrix[1] = matrix[0];

        uint s11 = matrix[1].length;
        Verification.Assert(s11 == 10);

        matrix[0][0] = 2;
        int m10 = matrix[1][0];
        Verification.Assert(m10 == 2);
    }
}

