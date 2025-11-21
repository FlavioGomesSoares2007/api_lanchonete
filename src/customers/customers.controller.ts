import {
  Controller,
  Post,
  Body,
  ParseIntPipe,
  Param,
  Delete,
  Get,
  Patch,
} from '@nestjs/common';
import { CustomersService } from './customers.service';
import { Prisma } from '@prisma/client';

@Controller('customers')
export class CustomersController {
  constructor(private readonly customersService: CustomersService) {}

  @Post('add')
  async addCustomer(@Body() createCustomerDto: Prisma.clientesCreateInput) {
    return this.customersService.addCustomer(createCustomerDto);
  }

  @Post(':clientId/address')
  async addAddress(
    @Param('clientId', ParseIntPipe) clientId: number,
    @Body() data: Prisma.enderecoCreateInput,
  ) {
    return this.customersService.addAddress(clientId, data);
  }

  @Post(':clientId/contact')
  async addContact(
    @Param('clientId', ParseIntPipe) clientId: number,
    @Body() data: Prisma.contatoCreateInput,
  ) {
    return this.customersService.addContact(clientId, data);
  }

  @Get(':clientId/contacts')
  async readContacts(@Param('clientId', ParseIntPipe) clientId: number) {
    return this.customersService.readcontacts(clientId);
  }

  @Get(':clientId/addresses')
  async readAddresses(@Param('clientId', ParseIntPipe) clientId: number) {
    return this.customersService.readAddresses(clientId);
  }

  @Patch('contact/:contactId')
  async updateContact(
    @Param('contactId', ParseIntPipe) contactId: number,
    @Body() data: Prisma.contatoUpdateInput,
  ) {
    return this.customersService.updateContact(contactId, data);
  }

  @Patch('address/:addressId')
  async updateAddress(
    @Param('addressId', ParseIntPipe) addressId: number,
    @Body() data: Prisma.enderecoUpdateInput,
  ) {
    return this.customersService.updateAddress(addressId, data);
  }

  @Delete(':clientId/delete')
  async deleteCustomer(@Param('clientId', ParseIntPipe) clientId: number) {
    return this.customersService.deleteCustomer(clientId);
  }

  @Delete('address/:addressId/delete')
  async deleteAddress(@Param('addressId', ParseIntPipe) addressId: number) {
    return this.customersService.deleteAddress(addressId);
  }

  @Delete('contact/:contactId/delete')
  async deleteContact(@Param('contactId', ParseIntPipe) contactId: number) {
    return this.customersService.deleteContact(contactId);
  }
}
