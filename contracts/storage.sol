// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

contract Storage {
    struct  S {
        int a;
        bool b;
    }

    S s3;
    S s4;
    S[] s5;

    int[] public arrayStorage;

    constructor(){

    }

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

    function isShallow(int val) public pure returns (int) {
        S[] memory lst = new S[](10);
        lst[1] = lst[0];
        lst[0].a = val;
        return lst[1].a;
    }

    // Static Array does not work in storage
    // function isShallowStorage() public returns (int) {
    //     s5 = new S[](10);
    //     s5[1] = s5[0];
    //     s5[0].a = 1;
    //     return s5[1].a;
    // }

    // Dynamic Arrays do not work in memory
    // function isShallowDynamic() public pure returns (int) {
    //     S[] memory lst;
    //     S memory s0;
    //     lst.push(s0);
    //     s0.a = 1;
    //     return lst[1].a;
    // }

    function usingStorage() public returns (int, int) {
        s5.push(s3);
        s3.a = 1;
        S memory s0;
        s0.a = 2;
        s5.push(s0);
        s0.a = 3;

        return (s5[0].a, s5[1].a);
    }

    function copyingStructLocally(int v) pure public returns (int) {
        S memory s0;
        S memory s1;

        s1 = s0;
        s0.a = v;

        return s1.a;
    }

    function usingArrayStorage() public{
        arrayStorage.push(0);
        arrayStorage.push(1);
    }

    function getArray(uint p) view  public returns (int){
        return arrayStorage[p];
    }

    function getArrayLenght() view public returns (uint){
        return arrayStorage.length;
    }
}
