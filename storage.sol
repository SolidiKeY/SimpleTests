// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

contract Storage {
    struct  S {
        int a;
        bool b;
    }

    S s3;
    S s4;

    function useArray() public view returns (bool, bool) {
        S[] memory lst = new S[](10);
        S memory s1 = lst[0];
        S memory s2 = lst[1];
        int a1 = s1.a;
        int a2 = s2.a;

        bool ba1a2 = a1 == a2;
        bool outside = s3.a == s4.a;
        return (ba1a2, outside);
    }
}
