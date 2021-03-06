//+------------------------------------------------------------------+
//|                                                     RsiMa_EA.mq4 |
//|                                                      Alessio Ena |
//|                                                                  |
//+------------------------------------------------------------------+

#property copyright "Alessio Ena"
#property link      ""
#property version   "1.00"
#property strict
#property indicator_chart_window
#include <WinUser32.mqh>

//+------------------------------------------------------------------+

//Parametri regolabili (External Parameters)

extern int    TakeProfit=100; //Definizione del Take Profit
extern int    StopLoss=50; //Definizione dello Stop Loss
extern double Lotti=0.10;  //Numero di lotti aperti a mercato
extern double rsi_period=5;   //Periodo del Relative Strenght Index

//Altri parametri

input int MagicNum=2345;   //ID delle operazioni aperte
double pips;   /*Dichiarazione della variabile 'pips' utilizzata nella funzione Init per
                 calcolare correttamente i pips per ogni cross valutario.*/

double ticksize = MarketInfo(Symbol(),MODE_TICKSIZE)


//Dichiarazione degli indicatori
   
double rsi = iRSI(_Symbol,PERIOD_CURRENT,rsi_period,PRICE_CLOSE,1);
double Fast_MA =iMA(_Symbol,PERIOD_CURRENT,50,0,MODE_SMA,0,1);
double Slow_MA = iMA(_Symbol,PERIOD_CURRENT,100,0,MODE_SMA,0,1);


/*Assunto che l'algoritmo debba aprire una posizione alla volta è stata definita
  una funzione booleana che restituisca true quando non ci sono altri ordini aperti (Ordini totali=0) e 
  che restiuisca false quando c'è un altro ordine aperto*/

bool limiteOrd()  
  {
   int limite=OrdersTotal();
   for(int i=0; i<limite; i++)
     {
      if(!OrderSelect(i,SELECT_BY_POS))
      return false;

      if(OrdersTotal()==0)
        {
         i--;
        }
     }
   return true;
  }
  
   
//+------------------------------------------------------------------+

//Funzione init()
/*La funzione init() contiene una frazione di codice che viene eseguita una sola volta ed
  esclusivamente durante l'apertura del programma*/

int init()
  {
   Comment(AccountBalance()+" "+AccountEquity());  //Visualizza a video l'equity e il balance dell'account
   
   if(ticksize==0.00001 || ticksize==0.001)
      pips=ticksize*10;
   else
      pips = ticksize;
   return(INIT_SUCCEEDED);}
      
//+------------------------------------------------------------------+

void OnTick()
  {


   if(limiteOrd()==true){  /*Prima di verificare se si possa o meno aprire un ordine a mercato, grazie al richiamo
                             della funzione limiteOrd, l'algoritmo stabilisce se ci sono delle operazioni che non 
                             sono state ancora chiuse*/ 
   
            //Ordine buy:
         
         if(Fast_MA>Slow_MA && rsi<=30 && Close[0]<Close[1]){
            OrderSend(Symbol(),0,Lotti,Ask,3,Ask-(StopLoss*pips),Ask+(TakeProfit*pips),NULL,MagicNum,0,Green);
           }
           
            //Ordine sell:
            
         if(Fast_MA<Slow_MA && rsi>=70 && Close[0]>Close[1]){
           OrderSend(Symbol(),1,Lotti,Bid,3,Bid+(StopLoss*pips),Bid-(TakeProfit*pips),NULL,MagicNum,0,Red);  
           }

      }

    }
    

//+------------------------------------------------------------------+
