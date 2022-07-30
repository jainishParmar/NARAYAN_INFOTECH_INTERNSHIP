<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;

use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Mail;

use App\Models\User;
use App\Mail\NotifyMail;

use Validator;


class AuthController extends Controller
{
    /**
     * Create a new AuthController instance.
     *
     * @return void
     */
    public function __construct() {
        $this->middleware('auth:api', ['except' => ['login', 'register','forgetpassword','resetPassword','compareOtp','test']]);
    }

    /**
     * Get a JWT via given credentials.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function login(Request $request){
    	$validator = Validator::make($request->all(), [
            'email' => 'required|email',
            'password' => 'required|string|min:6',
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        if (! $token = auth()->attempt($validator->validated())) {
            return response()->json(['error' => 'Unauthorized'], 401);
        }

        return $this->createNewToken($token);
    }

    /**
     * Register a User.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function register(Request $request) {
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|between:2,100',
            'email' => 'required|string|email|max:100|unique:users',
            'password' => 'required|string|min:6',
            'phone'=> 'required|string|min:10|max:10'
        ]);

        if($validator->fails()){
            return response()->json($validator->errors()->toJson(), 400);
        }

        $user = User::create(array_merge(
                    $validator->validated(),
                    ['password' => bcrypt($request->password)]
                ));

        return response()->json([
            'message' => 'User successfully registered',
            'user' => $user
        ], 201);
    }


    /**
     * Log the user out (Invalidate the token).
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function logout() {
        auth()->logout();

        return response()->json(['message' => 'User successfully signed out']);
    }

    /**
     * Refresh a token.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function refresh() {
        return $this->createNewToken(auth()->refresh());
    }

    /**
     * Get the authenticated User.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function userProfile() {
        return response()->json(auth()->user());
    }

    public function forgetpassword(Request $req ) {
        $email = $req -> email;
        $userExist = User::where("email",$email)->get('email');
       
        
        if(count($userExist) ==1){
            $otp = rand(100000,999999);
            $affected = User::where('email',$req->email)->update(['otp' => $otp]);
            $receiver =  $userExist[0]->email;

            $details = ['title'=>'One Time Verification Code','body'=> 'Your One Time Verification Code is '.$otp];
            Mail::to($receiver)->send(new NotifyMail($details) );
            
            return response()->json([
                'message' => $userExist[0]->email,
                
            ], 200);
        }else{return response()->json([
            'message' => 'User doesn`t Exist ',
            
        ], 404);
        }
    }

    public function resetPassword(Request $req){
        $validator = Validator::make($req->all(), [
            
            'email' => 'required|email',
            'password' => 'required|string|min:6',
           
        ]);

        if($validator->fails()){
            return response()->json($validator->errors()->toJson(), 400);
        }


        $affected = User::where('email',$req->email)
              ->update(['password' => bcrypt($req->password)]);


        if($affected==1){

        
        return response()->json([
            'message'=> "updated successfully",
        ],200);
    }else{
        return response()->json([
            'message'=>"error occured while updataing password"
        ],201);
    }




    }

    public function compareOtp(Request $req){

        $email = $req->email;
        $otp = $req->otp;
        $dbOtp = User::where("email",$email)->get('otp');
        
        if(!strcmp($otp , $dbOtp[0]->otp)){
            return response()->json([
                'message'=> "Otp verified",
            ],200);
        }else{
            return response()->json([
                'message'=> "Otp Doesn't verified",
            ],201);
        }

    }
    public function test(){
        $details = ['title'=>'Mail From Jainish Parmar','body'=>'this is for testing mail suing gmail'];

        Mail::to("parmarjayu003@gmail.com")->send(new NotifyMail($details) );
        return "Email sent";
      } 
    



    /**
     * Get the token array structure.
     *
     * @param  string $token
     *
     * @return \Illuminate\Http\JsonResponse
     */
    protected function createNewToken($token){
        return response()->json([
            'access_token' => $token,
            'token_type' => 'bearer',
            'expires_in' => auth()->factory()->getTTL() * 60,
            'user' => auth()->user()
        ]);
    }

}