<?php

namespace App\Http\Controllers\frontend;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class DonationsController extends Controller
{
    public function index(){
        return view('donations');
    }
}

