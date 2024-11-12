Public class test_cls{

    Public String transid{get;set;}
    
    Public test_cls(){
    
       transid = ApexPages.currentPage().getParameters().get('transid');
    
        
    }

}