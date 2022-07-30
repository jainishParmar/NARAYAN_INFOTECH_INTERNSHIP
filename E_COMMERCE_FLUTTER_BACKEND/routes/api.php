<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\ItemController;


/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/


Route::group([
    'middleware' => 'api',
    'prefix' => 'auth'

], function ($router) {
    Route::post('/login', [AuthController::class, 'login']);
    Route::post('/register', [AuthController::class, 'register']);
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::post('/refresh', [AuthController::class, 'refresh']);
    Route::get('/user-profile', [AuthController::class, 'userProfile']);
    Route::get('/forget-password/{email}', [AuthController::class, 'forgetpassword']);
    Route::post('/reset-password',[AuthController::class, 'resetPassword']);
    Route::get('/compare-otp/{email}/{otp}',[AuthController::class, 'compareOtp']);





});

Route::group([
    'middleware'=>'api',
    'prefix'=>'inventory'
],function($router){
    Route::get('/all',[ItemController::class,'getallItems']);
    Route::get('/popular_items',[ItemController::class,'getPopularItems']);
    Route::get('/popular_items/{search}',[ItemController::class,'searchProductItems']);

    Route::get('/recommanded_items',[ItemController::class,'getRecommandedItems']);
    Route::post('/cart',[ItemController::class,'storeCartItems']);
    Route::post('/order',[ItemController::class,'storeOrderItems']);
    Route::get('/order/{email}',[ItemController::class,'getOrderItems']);


    Route::get('/cart/{email}',[ItemController::class,'getCartItems']);
    Route::get('/cart_delete/{email}',[ItemController::class,'deleteCart']);
    Route::get('/zero_quantity_cart_delete/{email}/{id}',[ItemController::class,'deletezeroquantity']);


    Route::get('/cart_total_amount/{email}',[ItemController::class,'getTotalCartAmount']);
    Route::get('/cart_total_items/{email}',[ItemController::class,'totalCartItems']);
    Route::get('/cart_item_curren_quantity/{email}/{cart_product_id}',[ItemController::class,'getQuantityofParticularCart']);
    Route::get('/cart_item_price/{email}/{cart_product_id}',[ItemController::class,'getParticularPrice']);




});
Route::group([
    'middleware'=>'api',
    
],function($router){
    Route::get("/uploads/{abc}",[ItemController::class,'getImages']);


});
