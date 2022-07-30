<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Item;
use App\Models\Cart;
use App\Models\Order;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;



class ItemController extends Controller
{  

    protected $maxAttempts = 1000; // Default is 5
    protected $decayMinutes = 2; // Default is 1

    public function index(){
        return view("upload");
    }

    public function store(Request $req ){
      $img1 =  $req->file('img1')->store('uploads');
      $img2 = $req->file('img2')->store('uploads');
      $img3 =$req->file('img3')->store('uploads');
      $img4 = $req->file('img4')->store('uploads');
      $img5 = $req->file('img5')->store('uploads');

       $item = new Item;
       $item->item_name = $req['item_name'];  
       $item->price=$req['price'];
       $item->description=$req['desc'];
       $item->type_id=$req['tid'];
       $item->img_1=$img1 ;
       $item->img_2=$img2;
       $item->img_3=$img3;
       $item->img_4=$img4;
       $item->img_5=$img5; 
       $item->save(); 

    }

    public function getallItems(Request $req)
    {
                $list = Item::get();
                $data =  [
                    'total_size' => $list->count(),
                    'offset' => 0,
                    'items' => $list
                ];
                return response()->json($data, 200);


    }


    public function getPopularItems(Request $req)
    {
                $list = Item::where("type_id",1)->get();
                $data =  [
                    'total_size' => $list->count(),
                    'offset' => 0,
                    'items' => $list
                ];
                return response()->json($data, 200);


    }
    public function getRecommandedItems(Request $req)
    {
                $list = Item::where("type_id",2)->get();
                $data =  [
                    'total_size' => $list->count(),
                    'offset' => 0,
                    'items' => $list
                ];
                return response()->json($data, 200);


    }
    public function searchProductItems(Request $req)
    {

                $serchword = $req->search;
                $list = Item::where("item_name",'LIKE', '%'.$serchword.'%')->orderBy('created_at','DESC')->get();
                $data =  [
                    'total_size' => $list->count(),
                    'offset' => 0,
                    'items' => $list
                ];
                return response()->json($data, 200);


    }
    


    
    
    


    public function getImages(Request $req){


        $abc = $req->abc;
        return response()->file(public_path("/storage/${abc}"));

    }


    public function StoreCartItems(Request $req){

        $mail = $req['email'];
        $id = $req['cart_product_id'];
        $reqquantity = $req['quantity'];

        $list = Cart::where("email",$mail)->where("cart_product_id",$id)->get();

        if(count($list)==0){
            $cart = new Cart;
            $cart->cart_product_id = $req['cart_product_id'];
            $cart->name = $req['name'];  
            $cart->price=$req['price'];
            $cart->img=$req['img'] ;
            $cart->email=$req['email'];
            $cart->quantity=$req['quantity'];
            $cart->save(); 

        }else if(count($list)==1){
           
            // return $prevquantity[0]->quantity;
             $newquantity =$reqquantity;
             Cart::where("email",$mail)->where("cart_product_id",$id)->update(array('quantity'=>$newquantity));
        }
        return response()->json("Cart Stored In Database Succesfully", 200);
    }
       


    public function storeOrderItems(Request $req){

        $order = new Order;
        $order->order_product_id = $req['cart_product_id'];
        $order->name = $req['name'];  
        $order->price=$req['price'];
        $order->img=$req['img'] ;
        $order->email=$req['email'];
        $order->quantity=$req['quantity'];
        $order->time=$req['time'];
        $order->save(); 
        return response()->json("Order Stored In Database Succesfully", 200);

    }

    public function getCartItems(Request $req)
    {
        $email=$req->email;
                $list = Cart::where("email",$email)->orderBy('created_at','DESC')->get();
                $data =  [
                    'total_size' => $list->count(),
                    'offset' => 0,
                    'items' => $list
                ];
                return response()->json($data, 200);


    }
    public function getOrderItems(Request $req){
        $email = $req->email;
      
        $list = Order::Where("email",$email)->get();
        
        if(count($list)==0){
            $data =  [
                'total_size' => $list->count(),
                'offset' => 0,
                'items' => $list            ];
            return response()->json($data, 200);

        }else{
          
              
           
            $data =  [
                'total_size' => $list->count(),
                'offset' => 0,
                'items' => $list,
            ];
            return response()->json($data, 200);
        }


    }

    

    public function totalCartItems(Request $req){
        $email = $req->email;
        $list = Cart::where("email",$email)->sum('quantity');
        return $list;


    }

    public function getTotalCartAmount(Request $req){
        $email=$req->email;
        $list = Cart::where("email",$email)->orderBy('created_at','DESC')->select('quantity','price')->get();
        $totalsum = 0;
        for($i = 0;$i<count($list);$i++){
            $totalsum += $list[$i]->quantity * $list[$i]->price;
        }
        return $totalsum;

    }

    public function getParticularPrice(Request $req){
        $email= $req->email;
        $cart_product_id = $req->cart_product_id;

        $list = Cart::where("email",$email)->where("cart_product_id",$cart_product_id)->get('price');

        return $list[0]->price;
    }


    public function getQuantityofParticularCart(Request $req){
        $email= $req->email;
        $cart_product_id = $req->cart_product_id;

        $list = Cart::where("email",$email)->where("cart_product_id",$cart_product_id)->get();

        if(count($list)==0){
            return count($list);
        }elseif(count($list)==1){
            $list1 = Cart::where("email",$email)->where("cart_product_id",$cart_product_id)->get('quantity');
            return $list1[0]->quantity;
        }



    }

    public function deleteCart(Request $req){
        $email= $req->email;
        $list = Cart::where("email",$email)->delete();
        return response()->json("Cart Deleted SuccessFully", 200);


    }

    public function deletezeroquantity(Request $req){
        $email = $req->email;
        $id = $req->id;
        Cart::where("email",$email)->where("cart_product_id",$id)->delete();
        return response()->json("Cart with Zero Quantity Deleted SuccessFully", 200);

    }




}
