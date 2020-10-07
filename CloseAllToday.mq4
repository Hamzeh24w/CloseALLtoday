//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2018, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
void OnStart()
  {
//---

   closeAllToday();

  }
//+------------------------------------------------------------------+
void closeAllToday()
  {

   int currentTime = TimeCurrent();
   int currentHour = TimeHour(currentTime);
   int currentMinute = TimeMinute(currentTime);
   int startofday = currentTime - (currentHour*3600 + currentMinute*60);


   for(int i = OrdersTotal() -1 ; i >= 0 ; i--)
     {
     RefreshRates();
      if(OrderSelect(i,SELECT_BY_POS))
        {
         if(OrderOpenTime() > startofday)
           {
            if(OrderType() ==  0)
              {
               if(!OrderClose(OrderTicket(),OrderLots(),Bid,0,clrGreen))
                 {
                  Print("ORDER CLOSE ERROR : " + GetLastError());
                  closeAllToday();
                 }
              }
            else if(OrderType() == 1)
                 {
                  if(!OrderClose(OrderTicket(),OrderLots(),Ask,0,clrRed))
                    {
                     Print("ORDER CLOSE ERROR : " + GetLastError());
                     closeAllToday();
                    }
                 }
           }
        }
     }

  }
//+------------------------------------------------------------------+
