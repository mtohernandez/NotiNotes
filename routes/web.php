<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\frontend\IndexController;
use App\Http\Controllers\frontend\NotesController;
use App\Http\Controllers\frontend\LoginController;
use App\Http\Controllers\frontend\DonationsController;
use App\Http\Controllers\frontend\OpenController;
use App\Http\Controllers\frontend\WallController;
use App\Http\Controllers\frontend\AboutController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', [IndexController::class, 'index']);
Route::get('/About', [AboutController::class, 'index']);
Route::get('/Login', [LoginController::class, 'index']);
Route::get('/Notes', [NotesController::class, 'index']);
Route::get('/Donations', [DonationsController::class, 'index']);
Route::get('/Open', [OpenController::class, 'index']);
Route::get('/Wall', [WallController::class, 'index']);
