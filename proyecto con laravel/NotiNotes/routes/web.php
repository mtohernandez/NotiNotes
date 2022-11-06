<?php

use Illuminate\Support\Facades\Route;
use app\Http\Controllers\frontend\openController;
use app\Http\Controllers\frontend\aboutController;
use app\Http\Controllers\frontend\loginController;
use app\Http\Controllers\frontend\notesController;
use app\Http\Controllers\frontend\wallController;
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
Route:: get('/',[openController::class, 'index']);

Route:: get('/',[aboutController::class, 'index']);
