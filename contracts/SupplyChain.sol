pragma solidity ^0.5.16;

contract SupplyChain{

    //model a landlord
    struct Landlord{
        uint landlordID;
        string landlordName;
        uint landlordContact;
        string landlordAddress;
        address laddr;
        bool isValue;
    }

    //model a seed dealer
    struct SeedDealer{
        uint dealerID;
        string dealerName;
        string dealerAddress;
        uint dealerContact;
        address saddr;
        bool isValue;
    }

    //model a seed
    struct Seed{
        uint seedID;
        string seedName;
        uint seedQuantity;
        bool isBought;
        bool isSale;
        uint seedcost;
        address saddr;
        address faddr;
    }


    //model a fertilizer
    struct Fertilizer{
        uint fertilizerID;
        string fertilizerName;
        uint fertilizerQuantity;
        bool isBought;
        bool isSale;
        uint fertilizerCost;
        address saddr;
        address faddr;
    }
    //model a land
    struct Landsale{
        uint landID;
        string landAddress;
        string soilType;
        //uint temperature;
        //uint humidity;
        //string cropType;
        uint area;
        uint cost;
        bool isBought;
        bool isSale;
        address laddr;
        address faddr;
    }

    //model a landlease
    struct Landlease{
        uint landID;
        string landAddress;
        string soilType;
        //uint temperature;
        //uint humidity;
        //string cropType;
        uint area;
        uint cost;
        uint duration;
        bool isBought;
        bool isLease;
        address laddr;
        address faddr;

    }

    //model a farmer
   struct Farmer {
       uint farmerID;
       string farmerName;
       uint farmerContact;
      string farmerAddress;
       address faddr;
       bool isValue;
   }

   //model crop
    struct Crop{
       uint cropID;
       string cropName;
       uint quantity;
       uint cropPrice;
        address faddr;
        address daddr;
        address raddr;
        address caddr;
        bool isBought; 
        bool isBoughtByRetailer;     
        bool isBoughtByConsumer;    
 } 

   //model a distributor
   struct Distributor{
       uint distID;
       string distName;
       uint distContact;
       string distAddress;
       address daddr;
       bool isValue;
   }
   
   //model a retailer
   struct Retailer{
       uint retailID;
       string retailName;
       uint retailContact;
       string  retailAddress;
       address raddr;
       bool isValue;
   }
   
   //model a consumer
   struct Consumer{
       uint consumerID;
       string consumerName;
       uint consumerContact;
       string consumerAddress;
       address caddr;
       bool isValue;
   }

   mapping(address => Landlord) public mlandlord;
   mapping(address => SeedDealer) public mdealer;
   mapping(uint => Landlease) public mlland;
   mapping(uint => Landsale) public msland;
   mapping(address => Farmer) public mfarmer;
   mapping(uint => Seed) public mseed;
   mapping(uint => Fertilizer) public mfertilizer;
   mapping(uint => Crop) public mcrop;
   //mapping(uint => Crop) public dcrop;
   mapping(address => Distributor) public mdist;
   mapping(address => Retailer) public mretail;
   mapping(address => Consumer) public mconsumer;
   

   //count of crop
   uint[] public leaseArr;
   uint[] public saleArr;
   uint[] public seedArr;
   uint[] public fertilizerArr;
   uint[] public cropArr;
   uint[] public distCropArr;
   uint[] public consumerCropArr;
   uint[] public temp;
   address[] public farmerAdd;
   address[] public distAdd;
   address[] public retailAdd;
   uint public landlordCount;
   uint public dealerCount;
   uint public leaseCount;
   uint public seedCount;
   uint public fertilizerCount;
   uint public saleCount;
   uint public farmerCount;
   uint public cropCount;
   uint public distCount;
   uint public retailCount;
   uint public consumerCount;
   uint public distCropCount;
   uint public retailCropCount;
   uint public consumerCropCount;


   //event for landlord
   event landlordCreated(
       uint landlordID,
       string landlordName,
       uint landlordContact,
       string landlordAddress
   );
   
   //event for land sale
   event landForSale (
       uint landID,
       string landAddress,
       string soilType,
       //uint temperature,
       //uint humidity,
       //string cropType,
       uint area,
       uint cost
   );

   //event for lease
   event landForLease(
       uint landID,
       string landAddress,
       string soilType,
       //uint temperature,
       //uint humidity,
       //string cropType,
       uint area,
       uint cost,
       uint duration
   );

 
   //event for seedDealer
   event seedDealerCreated(
        uint dealerID,
        string dealerName,
        uint dealerContact,
        string dealerAddress
   );

   //event for seedCreated
   event seedCreated(
        uint seedID,
        string seedName,
        uint seedcost,
        uint seedQuantity
   );

   //event for fertilizerCreated
   event fertilizerCreated(
        uint fertilizerID,
        string fertilizerName,
        uint fertilizerCost,
        uint fertilizerQuantity
   );

   // event for farmer
   event farmerCreated (
       uint farmerID,
       string farmerName,
       uint farmerContact,
       string farmerAddress
   );

   // event for crop
   event cropCreated (
       uint cropID,
       string cropName,
       uint quantity,
       uint cropPrice,
       address faddr
   );

   //event for farmer land purchase 
   event landPurchaseLease (
       uint landID
   );
    event landPurchaseSale (
       uint landID
   );
   //evbent for seed purchase
   event seedPurchase(
       uint seedID
   );
   //event for fertilizer purchase
   event fertilizerPurchase(
       uint fertilizerID
   );

   //event for distributor 
   event distCreated (
       uint distID,
       string distName,
       uint distContact,
       string distAddress
   );

   //event for distributor crop
   event distCrop (
       uint cropID
   );
   
   //event for retailer
   event retailCreated (
       uint retailID,
       string retailName,
       uint retailContact,
       string retailAddress
   );

   //event for retail adding crop
   event retailCrop (
       uint cropID
   );

   //event for consumer
   event consumerCreated(
       uint consumerID,
       string consumerName,
       uint consumerContact,
       string consumerAddress
   );

  // event for consumer adding crop
  event consumerCrop(
      uint cropID
  );

    //add new Landlord
    function newLandlord(
        uint _landlordID,
        string memory _landlordName,
        uint _landlordContact,
        string memory _landlordAddress
    ) public {
        Landlord storage _newlandlord = mlandlord[msg.sender];

        // Only allows new records to be created
         require(!mlandlord[msg.sender].isValue);
        _newlandlord.laddr = msg.sender;
        _newlandlord.landlordID = _landlordID;
        _newlandlord.landlordName = _landlordName;
        _newlandlord.landlordAddress = _landlordAddress;
        _newlandlord.landlordContact = _landlordContact;
        _newlandlord.isValue = true;
        landlordCount++;
        emit landlordCreated(_newlandlord.landlordID, _landlordName, _landlordContact,_landlordAddress);
    }

    //landlord adds new land for sale
    function addLandSale (
        uint _landID,
        string memory _landAddress,
        string memory _soilType,
        //uint _temperature,
        //uint _humidity,
        //string memory _cropType,
        uint _area,
        uint _cost 
    ) public {
        Landsale storage _newland = msland[_landID];
        _newland.laddr = msg.sender;
        _newland.landID = _landID;
        _newland.landAddress = _landAddress;
        _newland.soilType = _soilType;
        //_newland.temperature=_temperature;
        //_newland.humidity=_humidity;
        //_newland.cropType=_cropType;
        _newland.area=_area;
        _newland.cost=_cost;
        saleCount++;
        saleArr.push(_landID);
        emit landForSale(_newland.landID, _landAddress, _soilType,_area,_cost);
    }

    // //lease function
     function addLandLease (
        uint _landID,
      //  string memory _landName,
        string memory _landAddress,
        string memory _soilType,
        //uint _temperature,
        //uint _humidity,
        //string memory _cropType,
        uint _area,
        uint _cost,
        uint _duration
    ) public {
        Landlease storage _newland = mlland[_landID];
        _newland.laddr = msg.sender;
        _newland.landID = _landID;
       // _newland.landName = _landName;
        _newland.landAddress = _landAddress;
        _newland.soilType = _soilType;
        //_newland.temperature=_temperature;
        //_newland.humidity=_humidity;
        //_newland.cropType=_cropType;
        _newland.area=_area;
        _newland.cost=_cost;
        _newland.duration=_duration;
        leaseCount++;
        leaseArr.push(_landID);
        emit landForLease(_newland.landID, _landAddress, _soilType,_area,_cost,_duration);
    }
    
    //add new seedDealer
    function newSeedDealer (
        uint _dealerID,
        string memory _dealerName,
        uint _dealerContact,
        string memory _dealerAddress
    ) public {
        SeedDealer storage _newdealer = mdealer[msg.sender];

        // Only allows new records to be created
        require(!mdealer[msg.sender].isValue);
        _newdealer.saddr = msg.sender;
        _newdealer.dealerID = _dealerID;
        _newdealer.dealerName = _dealerName;
        _newdealer.dealerAddress = _dealerAddress;
        _newdealer.dealerContact = _dealerContact;
        _newdealer.isValue = true;
        dealerCount++;
        emit seedDealerCreated(_newdealer.dealerID, _dealerName, _dealerContact,_dealerAddress);
    }

    //add new seed
    function newSeed (
        uint _seedID,
        string memory _seedName,
        uint _seedcost,
        uint _seedQuantity
    ) public {
        Seed storage _newseed = mseed[_seedID];

        // Only allows new records to be created
        //require(!mseed[msg.sender].isValue);
        _newseed.saddr = msg.sender;
        _newseed.seedID = _seedID;
        _newseed.seedName = _seedName;
        _newseed.seedcost = _seedcost;
        _newseed.seedQuantity = _seedQuantity;
        //_newseed.isValue = true;
        seedArr.push(_seedID);
        seedCount++;
        emit seedCreated(_newseed.seedID, _seedName, _seedcost, _seedQuantity);
    }

    //add new fertilizer
    function newFertilizer (
        uint _fertilizerID,
        string memory _fertilizerName,
        uint _fertilizerCost,
        uint _fertilizerQuantity
    ) public {
        Fertilizer storage _newfertilizer = mfertilizer[_fertilizerID];

        // Only allows new records to be created
        //require(!mfertilizer[msg.sender].isValue);
        _newfertilizer.saddr = msg.sender;
        _newfertilizer.fertilizerID = _fertilizerID;
        _newfertilizer.fertilizerName = _fertilizerName;
        _newfertilizer.fertilizerCost = _fertilizerCost;
        _newfertilizer.fertilizerQuantity = _fertilizerQuantity;
       // _newfertilizer.isValue = true;
        fertilizerArr.push(_fertilizerID);
        fertilizerCount++;
        emit fertilizerCreated(_newfertilizer.fertilizerID, _fertilizerName, _fertilizerCost, _fertilizerQuantity);
    }

    //add new farmer
    function newFarmer (
        uint _farmerID,
        string memory _farmerName,
        uint _farmerContact,
        string memory _farmerAddress
    ) public {
        Farmer storage _newfarmer = mfarmer[msg.sender];

        // Only allows new records to be created
        require(!mfarmer[msg.sender].isValue);
        _newfarmer.faddr = msg.sender;
        _newfarmer.farmerID = _farmerID;
        _newfarmer.farmerName = _farmerName;
        _newfarmer.farmerAddress = _farmerAddress;
        _newfarmer.farmerContact = _farmerContact;
        _newfarmer.isValue = true;
        farmerAdd.push(msg.sender);
        farmerCount++;
        emit farmerCreated(_newfarmer.farmerID, _farmerName, _farmerContact,_farmerAddress);
    }

    //add crop by old farmer
     function addCrop(
        uint _cropID,
        string memory _cropName,
        uint _quantity,
        uint _cropPrice
    ) public {
        Crop storage _newcrop = mcrop[_cropID];
        //Farmer storage _newfarmer = mfarmer[_farmerID];
       
        _newcrop.faddr = msg.sender;
        _newcrop.cropID = _cropID;
        _newcrop.cropName = _cropName;
        _newcrop.quantity = _quantity;
        _newcrop.cropPrice = _cropPrice;
        cropCount++;
        cropArr.push(_cropID);
        emit cropCreated(_newcrop.cropID, _cropName, _quantity, _cropPrice, _newcrop.faddr);
    }

    //farmer purchase land lease
     function purchaseLandLease (
        uint _landID
     ) public { 
        Landlease storage _newland = mlland[_landID];
        _newland.isBought = true;
        emit landPurchaseLease(_newland.landID);
    }
  
    //farmer purchase sale
     function purchaseLandSale (
        uint _landID
     ) public { 
        Landsale storage _newland = msland[_landID];
        _newland.isBought = true;
        emit landPurchaseSale(_newland.landID);
    }

    //farmer purchase seed
    function purchaseSeed (
        uint _seedID
    ) public {
        Seed storage _newseed = mseed[_seedID];
        _newseed.isBought=true;
        emit seedPurchase(_newseed.seedID);
    }

    //farmer purchase fertilizer
    function purchaseFertilizer (
        uint _fertilizerID
    ) public {
        Fertilizer storage _newfertilizer = mfertilizer[_fertilizerID];
        _newfertilizer.isBought=true;
        emit fertilizerPurchase(_newfertilizer.fertilizerID);
    }

    //add new distributor
    function addDist(
        uint _distID,
        string memory _distName,
        uint _distContact,
        string memory _distAddress
    ) public {
        Distributor storage _newdist = mdist[msg.sender];

        require(!mdist[msg.sender].isValue);
        _newdist.daddr = msg.sender;
        _newdist.distID = _distID;
        _newdist.distName = _distName;
        _newdist.distContact = _distContact;
        _newdist.distAddress = _distAddress;
        _newdist.isValue = true;
        distAdd.push(msg.sender);
        distCount++;
        emit distCreated(_newdist.distID, _distName, _distContact, _distAddress);
    }

    //crop purchased by distributor
    function distAddCrop(
        uint _cropID
     ) public { 
        Crop storage _newcrop = mcrop[_cropID];
         _newcrop.daddr = msg.sender;
        _newcrop.isBought = true;
        emit distCrop(_newcrop.cropID);
    }

    
    
    //add new retailer
    function addRetail(
        uint _retailID,
        string memory _retailName,
        uint _retailContact,
        string memory _retailAddress
    ) public {
        Retailer storage _newretail = mretail[msg.sender];
        require(!mretail[msg.sender].isValue);
        _newretail.raddr = msg.sender;
        _newretail.retailID = _retailID;
        _newretail.retailName = _retailName;
        _newretail.retailContact = _retailContact;
        _newretail.retailAddress = _retailAddress;
        _newretail.isValue = true;
        retailAdd.push(msg.sender);
        retailCount++;
        emit retailCreated(_newretail.retailID, _retailName, _retailContact, _retailAddress);
    }

    //purchase crop by retailer
    function retailAddCrop(
        uint _cropID
     ) public { 
        Crop storage _newcrop = mcrop[_cropID];
        _newcrop.raddr = msg.sender;
        _newcrop.isBoughtByRetailer = true;
        emit retailCrop(_newcrop.cropID);
    }

     //add new consumer
    function addconsumer(
        uint _consumerID,
        string memory _consumerName,
        uint _consumerContact,
        string memory _consumerAddress
    ) public {
        Consumer storage _newconsumer = mconsumer[msg.sender];
        require(!mconsumer[msg.sender].isValue);
        _newconsumer.caddr = msg.sender;
        _newconsumer.consumerID = _consumerID;
        _newconsumer.consumerName = _consumerName;
        _newconsumer.consumerContact = _consumerContact;
        _newconsumer.consumerAddress = _consumerAddress;
        _newconsumer.isValue = true;
        consumerCount++;
        emit consumerCreated(_newconsumer.consumerID, _consumerName, _consumerContact, _consumerAddress);
    }

    //purchase crop by consumer
    function consumerAddCrop(
        uint _cropID
     ) public { 
        Crop storage _newcrop = mcrop[_cropID];
        _newcrop.caddr = msg.sender;
        _newcrop.isBoughtByConsumer = true;
        emit consumerCrop(_newcrop.cropID);
    }

}