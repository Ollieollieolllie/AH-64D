
class arifle_SPAR_01_blk_MRCO_Flash_F: arifle_SPAR_01_blk_F {
    author = "Rosd6(Dryden)";
    _generalMacro = "arifle_SPAR_01_blk_MRCO_Flash_F";
    baseWeapon = "arifle_SPAR_01_blk_F";
    scope = 1;
    class LinkedItems {
        class LinkedItemsOptic {
            slot = "CowsSlot";
            item = "optic_MRCO";
        };
        class LinkedItemsAcc {
            slot = "PointerSlot";
            item = "acc_flashlight";
        };
    };
};